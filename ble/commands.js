export function createBleCommandHandlers(deps) {
  const {
    getServer,
    getCmdCharUuid,
    getCmdWriteMode,
    getCmdWriteType,
    getCmdWriteData,
    setCmdOut,
    log,
    decodeValue,
    safeReadValue,
    hexFromBuf,
    asciiFromBuf,
    bufFromHex,
    bufFromAscii,
    clampStr,
    onNotify,
    maxWriteBytes = 244
  } = deps;

  function ensureWritePayloadSize(buf) {
    if (buf.byteLength === 0) throw new Error("Payload vide: écriture annulée.");
    if (buf.byteLength > maxWriteBytes) {
      throw new Error(`Payload trop long (${buf.byteLength} octets, max ${maxWriteBytes}).`);
    }
  }

  function confirmWriteIntent({ characteristic, writeType, mode, size }) {
    const ok = confirm(
      `Confirmer l'écriture BLE ?\n` +
      `Characteristic: ${characteristic}\n` +
      `Type: ${writeType}\n` +
      `Mode: ${mode}\n` +
      `Taille: ${size} octet(s)`
    );
    if (!ok) throw new Error("Écriture annulée par l'utilisateur.");
  }

  async function getCharByUuid(uuid) {
    const server = getServer();
    const u = (uuid || "").trim().toLowerCase();
    if (!u) throw new Error("Characteristic UUID vide.");

    const services = await server.getPrimaryServices();
    for (const svc of services) {
      try {
        const ch = await svc.getCharacteristic(u);
        if (ch) return { svc, ch };
      } catch (_) { /* continue */ }
    }
    throw new Error("Characteristic introuvable via getCharacteristic (UUID ou droits).");
  }

  async function cmdRead() {
    const server = getServer();
    if (!server?.connected) return;

    const u = getCmdCharUuid();
    try {
      const { svc, ch } = await getCharByUuid(u);
      if (!ch.properties.read) throw new Error("Lecture non supportée par cette caractéristique.");
      const buf = await safeReadValue(ch);
      if (!buf) throw new Error("Lecture impossible (droits/erreur).");

      const hx = hexFromBuf(buf);
      const asc = asciiFromBuf(buf);
      const decoded = decodeValue(svc.uuid, ch.uuid, buf);

      setCmdOut(`Valeur: hex=[${hx}] ascii="${asc}"` + (decoded ? ` dec=${JSON.stringify(decoded)}` : ""));
      log("INFO", "CMD_READ", { msg: "cmd read", service: svc.uuid, characteristic: ch.uuid, hex: hx, ascii: asc, decoded });
    } catch (e) {
      setCmdOut(`Erreur: ${String(e)}`);
      log("ERROR", "CMD_READ_ERR", { msg: String(e) });
    }
  }

  async function cmdWrite() {
    const server = getServer();
    if (!server?.connected) return;

    const u = getCmdCharUuid();
    const mode = getCmdWriteMode();
    const writeType = getCmdWriteType();
    const data = getCmdWriteData();

    try {
      const { svc, ch } = await getCharByUuid(u);

      if (writeType === "write" && !ch.properties.write) throw new Error("write non supporté.");
      if (writeType === "writeWithoutResponse" && !ch.properties.writeWithoutResponse) throw new Error("writeWithoutResponse non supporté.");

      let buf;
      if (mode === "hex") buf = bufFromHex(data);
      else buf = bufFromAscii(data);

      ensureWritePayloadSize(buf);
      confirmWriteIntent({ characteristic: ch.uuid, writeType, mode, size: buf.byteLength });

      const dv = new DataView(buf);

      if (writeType === "write") await ch.writeValue(dv);
      else await ch.writeValueWithoutResponse(dv);

      setCmdOut(`Écriture OK (${buf.byteLength} octets).`);
      log("INFO", "CMD_WRITE", {
        msg: "cmd write",
        service: svc.uuid,
        characteristic: ch.uuid,
        writeType,
        dataMode: mode,
        size: buf.byteLength,
        hex: hexFromBuf(buf),
        ascii: asciiFromBuf(buf)
      });
    } catch (e) {
      setCmdOut(`Erreur: ${String(e)}`);
      log("ERROR", "CMD_WRITE_ERR", { msg: String(e) });
      alert(`Écriture impossible: ${String(e)}`);
    }
  }

  async function cmdNotifyOn() {
    const server = getServer();
    if (!server?.connected) return;

    const u = getCmdCharUuid();

    try {
      const { svc, ch } = await getCharByUuid(u);
      if (!(ch.properties.notify || ch.properties.indicate)) throw new Error("Notifications/indications non supportées.");

      ch.addEventListener("characteristicvaluechanged", (ev) => {
        const dv = ev.target.value;
        const buf = dv.buffer.slice(dv.byteOffset, dv.byteOffset + dv.byteLength);
        const hx = hexFromBuf(buf);
        const asc = asciiFromBuf(buf);
        const decoded = decodeValue(svc.uuid, ch.uuid, buf);

        onNotify({ svcUuid: svc.uuid, chUuid: ch.uuid, buf, hx, asc, decoded, size: buf.byteLength });
      });

      await ch.startNotifications();
      log("INFO", "CMD_NOTIFY_ON", { msg: "notifications enabled", service: svc.uuid, characteristic: ch.uuid });
    } catch (e) {
      log("ERROR", "CMD_NOTIFY_ON_ERR", { msg: String(e) });
      alert(`Notif ON impossible: ${String(e)}`);
    }
  }

  async function cmdNotifyOff() {
    const server = getServer();
    if (!server?.connected) return;

    const u = getCmdCharUuid();

    try {
      const { svc, ch } = await getCharByUuid(u);
      await ch.stopNotifications();
      log("INFO", "CMD_NOTIFY_OFF", { msg: "notifications disabled", service: svc.uuid, characteristic: ch.uuid });
    } catch (e) {
      log("ERROR", "CMD_NOTIFY_OFF_ERR", { msg: String(e) });
      alert(`Notif OFF impossible: ${String(e)}`);
    }
  }

  return { cmdRead, cmdWrite, cmdNotifyOn, cmdNotifyOff };
}
