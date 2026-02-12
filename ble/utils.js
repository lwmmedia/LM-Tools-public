export const nowIso = () => new Date().toISOString();

export function msDelta(t0) {
  return Math.round(performance.now() - t0);
}

export function hexFromBuf(buf) {
  const u = new Uint8Array(buf);
  return [...u].map(b => b.toString(16).padStart(2, "0")).join(" ");
}

export function asciiFromBuf(buf) {
  const u = new Uint8Array(buf);
  let s = "";
  for (const b of u) s += (b >= 32 && b <= 126) ? String.fromCharCode(b) : ".";
  return s;
}

export function bufFromHex(text) {
  const cleaned = (text || "")
    .replace(/0x/gi, " ")
    .replace(/[^0-9a-fA-F]/g, " ")
    .trim();

  if (!cleaned) return new ArrayBuffer(0);

  const parts = cleaned.split(/\s+/).filter(Boolean);
  const bytes = parts.map(p => {
    if (p.length === 1) p = "0" + p;
    if (p.length !== 2) throw new Error(`Octet hex invalide: "${p}"`);
    const v = parseInt(p, 16);
    if (Number.isNaN(v)) throw new Error(`Octet hex invalide: "${p}"`);
    return v;
  });

  return new Uint8Array(bytes).buffer;
}

export function bufFromAscii(text) {
  const s = String(text ?? "");
  const u = new Uint8Array(s.length);
  for (let i = 0; i < s.length; i++) u[i] = s.charCodeAt(i) & 0xff;
  return u.buffer;
}

export function shortUuid(uuid) {
  const m = /^0000([0-9a-fA-F]{4})-0000-1000-8000-00805f9b34fb$/.exec(uuid);
  return m ? `0x${m[1].toUpperCase()}` : uuid;
}

export function propsToText(p) {
  const out = [];
  if (p.read) out.push("read");
  if (p.write) out.push("write");
  if (p.writeWithoutResponse) out.push("writeNoRsp");
  if (p.notify) out.push("notify");
  if (p.indicate) out.push("indicate");
  if (p.authenticatedSignedWrites) out.push("signedWrite");
  if (p.reliableWrite) out.push("reliableWrite");
  if (p.writableAuxiliaries) out.push("aux");
  return out.join(", ");
}

export async function safeReadValue(characteristic) {
  try {
    const dv = await characteristic.readValue();
    return dv.buffer.slice(dv.byteOffset, dv.byteOffset + dv.byteLength);
  } catch {
    return null;
  }
}

export function clampStr(s, max) {
  s = String(s ?? "");
  if (s.length <= max) return s;
  return s.slice(0, max) + "…";
}

export function downloadText(filename, text, mime = "text/plain") {
  const blob = new Blob([text], { type: mime });
  const url = URL.createObjectURL(blob);
  const a = document.createElement("a");
  a.href = url;
  a.download = filename;
  document.body.appendChild(a);
  a.click();
  a.remove();
  setTimeout(() => URL.revokeObjectURL(url), 1500);
}

export function csvEscape(v) {
  const s = String(v ?? "");
  if (/[,"\n]/.test(s)) return `"${s.replace(/"/g, '""')}"`;
  return s;
}
