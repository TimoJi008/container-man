// vite.config.ts

import { defineConfig } from 'vite';

export default defineConfig({
  server: {
    host: true, // bindet auf 0.0.0.0
    allowedHosts: ['container-man.onrender.com'],
  },
});
