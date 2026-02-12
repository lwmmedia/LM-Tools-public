// Décodage modulaire : ajoutez vos parseurs ici.
// Signature: decodeValue(serviceUuid, charUuid, buffer) -> object | null

import { shortUuid } from './utils.js';

function u16(dv, off=0, le=true){ return dv.getUint16(off, le); }
function i16(dv, off=0, le=true){ return dv.getInt16(off, le); }

export function decodeValue(serviceUuid, charUuid, buffer) {
  const svc = shortUuid(serviceUuid).toLowerCase();
  const ch  = shortUuid(charUuid).toLowerCase();

  // Battery Level: 0x180F / 0x2A19
  if (svc === "0x180f" && ch === "0x2a19" && buffer.byteLength >= 1) {
    const dv = new DataView(buffer);
    return { battery_percent: dv.getUint8(0) };
  }

  // Device Information Service (0x180A) : quelques chars fréquentes (si lisibles)
  // Manufacturer Name String: 0x2A29
  if (svc === "0x180a" && ch === "0x2a29") {
    return { manufacturer: tryAscii(buffer) };
  }
  // Model Number String: 0x2A24
  if (svc === "0x180a" && ch === "0x2a24") {
    return { model: tryAscii(buffer) };
  }
  // Serial Number String: 0x2A25
  if (svc === "0x180a" && ch === "0x2a25") {
    return { serial: tryAscii(buffer) };
  }

  // Exemple “capteur” générique : si payload 2 octets -> valeur u16
  // (à adapter à vos UUIDs)
  if (buffer.byteLength === 2) {
    const dv = new DataView(buffer);
    return { u16_le: u16(dv, 0, true), i16_le: i16(dv, 0, true) };
  }

  return null;
}

function tryAscii(buffer) {
  const u = new Uint8Array(buffer);
  let s = "";
  for (const b of u) s += (b >= 32 && b <= 126) ? String.fromCharCode(b) : "";
  return s || null;
}
