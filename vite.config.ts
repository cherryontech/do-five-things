import { defineConfig } from 'vite'
import FullReload from "vite-plugin-full-reload"
import RubyPlugin from 'vite-plugin-ruby'
import vue from '@vitejs/plugin-vue'

export default defineConfig({
  clearScreen: false,
  plugins: [
    RubyPlugin(),
    vue(),
    FullReload(["config/routes.rb", "app/views/**/*"], { delay: 300 }),
  ],

}
)