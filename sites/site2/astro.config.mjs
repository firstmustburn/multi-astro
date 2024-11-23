// @ts-check
import { defineConfig } from "astro/config";

// https://astro.build/config
export default defineConfig({
  server: {
    port: 8001,
    host: true,
  },
  vite: {
    server: {
      watch: {
        usePolling: true, //note required for WSL
      },
    },
    // resolve: {
    //   alias: {
    //     // '~': path.resolve(__dirname, './src'),
    //     // '@common': '../astro-common/src',
    //   },
    // },

  },
});
