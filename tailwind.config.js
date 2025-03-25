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
        sans: ['Righteous', ...defaultTheme.fontFamily.sans],
        subtle: ['Arial', ...defaultTheme.fontFamily.sans]
      },
      borderRadius: {
        'dft-md': '10px',
        'dft-sm': '5px',
        'dft-input': '20px'
      },
      colors: {
        'dft-white': '#FFFFFF',
        'dft-black': '#000000',
        'dft-grey': '#3a3a3a', // Dark grey
        'dft-grey-mid': '#D9D9D9', // Mid grey
        'dft-grey-light': '#FAFAFA', // Light grey
        'dft-primary': '#F196F9', // Candy pink
        'dft-secondary': '#90F8FF', // Light blue
        'dft-secondary-dimmed': '#68D5DC',
        'dft-accent': '#FF6584', // Coral
        'dft-error': '#FF6584', // Error (Coral)
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