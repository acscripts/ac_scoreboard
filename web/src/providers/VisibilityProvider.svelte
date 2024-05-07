<script lang="ts">
  import { useNuiEvent } from '../utils/useNuiEvent';
  import visibility from '../store/visibility';

  let isVisible: boolean;

  visibility.subscribe((visible) => {
    isVisible = visible;
  });

  useNuiEvent<boolean>('setVisible', (visible) => {
    visibility.set(visible);
  });
</script>

{#if isVisible}
  <slot />
{/if}
