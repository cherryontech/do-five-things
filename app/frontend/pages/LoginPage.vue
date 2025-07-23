<template>
  <div class="mx-auto max-w-sm">
    <div class="my-12 flex gap-2 justify-center items-end flex-wrap">
      <span class="bg-dft-primary w-14 h-14 rounded-lg inline-block text-dft-grey">
        <BaseIcon class="fill-dft-grey" icon="check" />
      </span>
      <h1 class="text-dft-primary text-4xl text-center -mb-1">
        {{ $t('labels.appName') }}
      </h1>
    </div>
    <p class="text-center">{{ $t('login.intro') }}</p>

    <div class="flex flex-col gap-2 mt-10">
      <div :class="loginHasError ? 'border-dft-error ring-dft-error' : 'border-dft-primary ring-dft-primary'"
        class="transition ease-in-out focus-within:ring-4 ring-inset flex flex-col items-baseline gap-4 py-5 px-9 border-2 rounded-dft-input">

        <label for="loginInput" class="flex items-center text-xl" :class="{ 'text-dft-error': loginHasError }">
          <span>{{ $t('login.loginInput.label') }}</span>
          <span v-if="loginHasError">*</span>
        </label>

        <input :aria-invalid="loginHasError || undefined" placeholder="ada@example.com"
          class="placeholder:text-gray-400 placeholder:italic w-full p-0 leading-none bg-transparent border-0 border-b" id="loginInput" type="text"
          :class="loginHasError ? 'border-dft-error' : 'border-dft-white'" v-model="loginEmail" />

        <BaseButton data-test="saveButton" class="my-5 ml-auto block" :hasError="loginHasError">
          {{ $t('login.loginInput.button') }}
        </BaseButton>
      </div>
    </div>

    <p class="mt-4 text-right">{{ $t('login.signUpCta.intro') }} <a href="/signup" class="underline">{{
      $t('login.signUpCta.linkText') }}</a></p>
  </div>
</template>

<script setup lang="ts">
import PublicLayout from '../layouts/PublicLayout.vue'
import BaseButton from '../components/BaseButton.vue'

import { ref } from 'vue'
import BaseIcon from '../components/BaseIcon.vue'

defineOptions({
  layout: PublicLayout
})

const loginHasError = ref(false)
const loginEmail = ref('')
</script>
