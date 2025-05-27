export { v1 as uuid } from "uuid";
import packageJson from "../package.json" with { type: "json" };

export const version = packageJson.version;
