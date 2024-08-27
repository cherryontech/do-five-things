<template>
  <main class="flex flex-col min-h-screen p-4 appBg">
    <header class="border-4">
      <a href="#footerNav">Skip to nav (TODO: Hide until focused with keyboard)</a>
    </header>
    <article class="grow">

      <slot />
    </article>
    <footer id="footerNav" class="rounded-t-xl bg-dft-secondary">
      <ul class="flex justify-center">
        <li class="basis-36 max-w-36">
          <NavLink linkDest="/settings" icon="cog">
            {{ $t('nav.settings') }}
          </NavLink>
        </li>
        <li class="basis-36 max-w-36">
          <NavLink linkDest="/today" icon="sun">
            {{ $t('nav.today') }}
          </NavLink>
        </li>
        <li class="basis-36 max-w-36">
          <NavLink linkDest="/progress" icon="thermometer">
            {{ $t('nav.progress') }}
          </NavLink>
        </li>
      </ul>

    </footer>
  </main>
</template>

<script setup>
import NavLink from '../components/NavLink.vue'
</script>