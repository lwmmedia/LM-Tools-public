# BLE Internal Analyzer

![Internal Tool](https://img.shields.io/badge/status-internal--tool-orange)
![Not for Production](https://img.shields.io/badge/environment-not--for--production-red)
![BLE](https://img.shields.io/badge/technology-BLE-blue)
![Web Bluetooth](https://img.shields.io/badge/WebBluetooth-required-green)

---

# Overview

BLE Internal Analyzer is a Web Bluetooth-based diagnostic tool designed for controlled technical environments.

It provides low-level BLE interaction for:

- GATT inspection
- Characteristic read/write
- Notification monitoring
- Session capture
- Protocol analysis
- Firmware validation

This tool is strictly intended for internal technical use.

---

# Scope

## Intended Use

- BLE device diagnostics
- Firmware testing (ESP32 / IoT / custom boards)
- GATT structure inspection
- Controlled reverse engineering
- IoT audit and validation
- Mesh BLE protocol observation

## Not Intended For

- Production control systems
- Public-facing deployment
- Industrial command interfaces
- RF certification or compliance testing

---

# Architecture

ble/
├── blue.html → Main application (UI + BLE logic)
├── utils.js → Helpers (buffers, logging, export)
├── parsers.js → Protocol decoding layer
└── README.md


## Component Responsibilities

### blue.html
- Web Bluetooth interface
- GATT inventory
- Command execution
- Profiling
- Logging
- Export features

### utils.js
- Buffer conversion (HEX / ASCII)
- Safe read helpers
- CSV formatting
- File export handling
- UUID formatting

### parsers.js
- Decoding abstraction layer
- Service-specific parsing logic
- Extendable protocol interpretation

---

# Functional Capabilities

## 1. GATT Inventory

- Lists primary services
- Lists characteristics and properties
- Attempts descriptor enumeration
- Performs best-effort sample read
- Structured technical output

---

## 2. Read / Write Operations

Supports:

- `read`
- `write`
- `writeWithoutResponse`
- `notify`
- `indicate`

Write payload formats:

- HEX (`01 02 ff`)
- ASCII (`HELLO`)

⚠ Write operations may alter device state.

---

## 3. Notification Monitoring

- Real-time capture
- Notification counter
- Time to first notification
- Payload size logging
- Automatic session logging

---

## 4. Profiling

Captures:

- Connection time (ms)
- GATT inventory duration
- First notification latency
- Total notification count

Useful for firmware stability validation.

---

## 5. Session Export

### JSON Export
Includes:

- Session metadata
- Device information
- Profiling data
- GATT inventory snapshot
- Full event log

### CSV Export
Exports event stream:

- Timestamp
- Event type
- Service UUID
- Characteristic UUID
- HEX payload
- ASCII payload
- Decoded data (if available)

---

# Deployment

Web Bluetooth requires HTTPS.

Recommended:

https://lwmmedia.github.io/LM-Tools-public/ble/blue.html


Bluefy direct launch:



bluefy://open?url=https://lwmmedia.github.io/LM-Tools-public/ble/blue.html


---

# Security & Compliance

## Operational Risks

- Write operations may reconfigure devices.
- Continuous notifications may increase power usage.
- Captured data may contain persistent identifiers.

---

## GDPR Considerations

Exports may include:

- Device IDs
- Serial numbers
- Persistent BLE identifiers
- Telemetry potentially linkable to individuals

When used in regulated environments (schools, public institutions, enterprises):

- Ensure lawful basis for processing
- Apply data minimization
- Secure exported files
- Define retention policy
- Avoid public distribution of raw captures

The tool does not transmit data externally.

---

# Technical Limitations

- BLE only (no classic Bluetooth BR/EDR)
- No RF sniffing
- iOS picker required
- Descriptor access may be restricted
- Browser security constraints apply
- No passive background scanning

---

# Extending the Parser

To add protocol decoding:

Edit `parsers.js`.

Example:

```javascript
if (svc === "custom_service_uuid" && ch === "custom_char_uuid") {
  return {
    field1: dv.getUint8(0),
    field2: dv.getUint16(1, true)
  };
}
Custom decoders enable structured protocol interpretation.

Liability Disclaimer

This tool is provided “as is” without warranty.

The author shall not be liable for:

Device malfunction

Data loss

Regulatory violations

Indirect or consequential damages

Use is entirely at your own risk.

Status

Internal technical utility
Not approved for production deployment
BLE diagnostic environment only
