<script lang="ts">
  import type SheetConfig from '$types/config';

  type $$Props = {
    title: SheetConfig['title'];
  };

  export let title: $$Props['title'] = {};

  const handleMissingImage = () => {
    title.logo = './logo.svg';
  };
</script>

<div class="flex h-8 select-none items-center gap-2">
  {#if title.logo !== false}
    <img
      class="h-full"
      style="color-scheme:dark;"
      src={title.logo ?? 'defaultTitleLogo'}
      alt="Server logo"
      on:error={handleMissingImage}
    />
  {/if}
  {#if title.text !== false}
    <p class="text-xl font-semibold">{title.text}</p>
  {/if}
</div>
