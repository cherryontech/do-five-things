<template>
  <div>
    <h1>{{ $t('pageTitles.settings') }}</h1>
    <p>Example computed string. It should say "today": {{ exampleComputedString }}</p>
   <p>This is the settings page (TODO: Refactor into a reusable, styled component)</p>
  </div>
</template>

<script setup lang="ts">
import { useI18n } from 'vue-i18n'
import { computed } from 'vue'

const { t } = useI18n()

const exampleComputedString = computed(() => {
  if (true === true) return t('pageTitles.today')
})
</script>