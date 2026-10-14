import { defineConfig } from "vite";
import dts from "vite-plugin-dts";

const external = (id: string) =>
  !id.startsWith("\0") && !id.startsWith(".") && !id.startsWith("/");

export default defineConfig({
  plugins: [dts({ entryRoot: "./src" })],
  build: {
    lib: {
      entry: "src/index.ts",
      fileName: "index",
      formats: ["es"],
    },
    rollupOptions: {
      external,
    },
  },
});
