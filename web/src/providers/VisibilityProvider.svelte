<script lang="ts">
  import visibility from '$store/visibility';

  let isVisible = $state(false);

  visibility.subscribe((visible) => {
    isVisible = visible;
  });
</script>

<!-- svelte-ignore slot_element_deprecated -->
{#if isVisible}
  <slot />
{/if}
