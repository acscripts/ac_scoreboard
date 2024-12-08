<script lang="ts">
  import config from '$store/config';

  const handleMissingImage = () => {
    $config.title.logo = './logo.svg';
  };
</script>

<div class="flex h-8 select-none items-center gap-2">
  {#if $config.title.logo !== false}
    <img
      class="h-full"
      style="color-scheme:dark;"
      src={$config.title.logo ?? 'defaultTitleLogo'}
      alt="Server logo"
      onerror={handleMissingImage}
    />
  {/if}
  {#if $config.title.text !== false}
    <p class="text-xl font-semibold">{$config.title.text ?? 'AC Scoreboard'}</p>
  {/if}
</div>
