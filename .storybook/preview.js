/** @type { import('@storybook/vue3').Preview } */

import enLocale from "../app/frontend/locales/en.json";
import { setup } from "@storybook/vue3";
import { createI18n } from "vue-i18n";

setup((app) => {
  const i18n = createI18n({
    locale: "en",
    messages: {
      en: enLocale
    },
    legacy: false
  })
  app.use(i18n)
})

const preview = {
  parameters: {
    controls: {
      matchers: {
        color: /(background|color)$/i,
        date: /Date$/i,
      },
    },
  },
};

export default preview;

