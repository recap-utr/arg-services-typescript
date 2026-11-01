export { v1 as uuid } from "uuid";
import pkg from "arg-services/package.json" with { type: "json" };

export const version = pkg.version;
