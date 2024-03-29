/// <reference types="vite" />
import path from "path";
import { defineConfig } from "vite";
import dts from "vite-plugin-dts";

const external = (id: string) =>
  !id.startsWith("\0") && !id.startsWith(".") && !id.startsWith("/");

export default defineConfig({
  plugins: [dts({ entryRoot: "./src" })],
  build: {
    lib: {
      entry: path.resolve(__dirname, "src/index.ts"),
      name: " arg-services",
      fileName: "index",
      formats: ["es"],
    },
    rollupOptions: {
      external,
    },
  },
});
