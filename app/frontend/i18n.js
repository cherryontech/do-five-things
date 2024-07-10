import { createI18n } from 'vue-i18n'
import en from './locales/en.json'

/**
 * @param {object} options - Options to be passed to [vue-i18n](https://vue-i18n.intlify.dev/api/general.html#i18nadditionaloptions)
 */
export const setupI18n = (options = {locale: 'en'}) => {
  const i18n = createI18n({
    legacy: false,
    locale: options.locale,
    fallbackLocale: 'en',
    messages: {
      en
    }
  })

  document.querySelector('html').setAttribute('lang', options.locale)

  return i18n
}