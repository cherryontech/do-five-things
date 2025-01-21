<template>
  <div class="mx-auto max-w-sm">
    <h1 class="mb-24 text-4xl text-center">{{ $t('pageTitles.progress') }}</h1>
    <p class="mb-16 text-xl text-center">
      {{ $t('emptyStates.progressPage.text1') }}
      <Link class="dft-prose-link" href="/today">
        {{ $t('emptyStates.progressPage.link1') }}
      </Link>
      {{ $t('emptyStates.progressPage.text2') }}
    </p>
  </div>
</template>

<script setup lang="ts">
import { Link, router } from '@inertiajs/vue3'

</script>