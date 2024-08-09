/** @type { import('@storybook/vue3-vite').StorybookConfig } */
const config = {
  stories: [
    "../app/**/*.stories.@(js|jsx|mjs|ts|tsx)",
    "../app/**/*.mdx",
  ],
  addons: [
    "@storybook/addon-links",
    "@storybook/addon-essentials",
    "@chromatic-com/storybook",
    "@storybook/addon-interactions",
  ],
  framework: {
    name: "@storybook/vue3-vite",
    options: {},
  },
};
export default config;
