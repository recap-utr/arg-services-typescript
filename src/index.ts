import pkg from "arg-services/package.json" with { type: "json" };

export const version = pkg.version;

/** @deprecated Use `crypto.randomUUID()` directly. */
export const uuid = (): string => crypto.randomUUID();
