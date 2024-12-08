import { defineConfig } from 'vite';
import { svelte } from '@sveltejs/vite-plugin-svelte';
import * as path from 'path';

export default defineConfig({
  plugins: [svelte()],
  base: './',
  server: {
    port: 3000,
  },
  build: {
    outDir: 'build',
  },
  resolve: {
    alias: {
      $utils: path.resolve('./src/utils'),
      $types: path.resolve('./src/types'),
      $store: path.resolve('./src/store'),
    },
  },
});
