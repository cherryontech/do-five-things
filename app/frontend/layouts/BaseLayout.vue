<template>
  <main class="flex flex-col min-h-screen bg-dft-grey">
    <header class="border-4">
      <a href="#footerNav">Skip to nav (TODO: Hide until focused with keyboard)</a>
    </header>
    <article class="grow">

      <slot />
    </article>
    <footer id="footerNav" class="bg-dft-secondary">
      <Link href="/settings">Settings</Link>
      <!-- TODO: Add route for /today -->
      <Link href="https://example.com/today">Today</Link>
      <!-- TODO: Add route for /progress -->
      <Link href="https://example.com/progress">Progress</Link>
    </footer>
  </main>
</template>

<script setup>
import { Link } from '@inertiajs/vue3'
</script>