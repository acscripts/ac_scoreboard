<script lang="ts">
  import visibility from '$store/visibility';

  let isVisible: boolean;

  visibility.subscribe((visible) => {
    isVisible = visible;
  });
</script>

{#if isVisible}
  <slot />
{/if}
