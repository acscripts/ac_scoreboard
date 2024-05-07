<script lang="ts">
  import data from '$store/data';
  import config from '$store/config';
  import locales from '$store/locales';
  import { cn } from '$utils/misc';
</script>

<div class="flex h-full flex-col gap-1">
  {#each $data.players as player}
    <div
      class={cn(
        'flex items-center justify-between gap-2 rounded-md bg-slate-700 px-2',
        $config.uppercaseNames && 'uppercase',
        $config.compactPlayers ? 'py-1' : 'py-2'
      )}
    >
      <span class="truncate">{player.name ?? $locales.anonymous_player}</span>
      {#if player.id !== undefined}
        <span class="min-w-9 flex-shrink-0 rounded-md bg-slate-800 px-2 text-center">{player.id}</span>
      {/if}
    </div>
  {/each}
</div>
