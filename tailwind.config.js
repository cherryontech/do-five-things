/** @type {import('tailwindcss').Config} */

const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.{js,jsx,ts,tsx,vue}',
    './app/views/**/*.{html,html.erb,erb}',
    './app/frontend/**/*.{js,jsx,ts,tsx,svelte,vue}',
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      colors: {
        'dft-white': '#FAFAFA',
        'dft-black': '#000000',
        'dft-grey': '#3a3a3a',
        'dft-primary': '#F196F9', // Candy pink
        'dft-secondary': '#90F8FF', // Light blue
        'dft-accent': '#FF6584', // Coral
      }
    },
  },
  corePlugins: {
    aspectRatio: false,
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
    require('@tailwindcss/aspect-ratio')
  ]
}