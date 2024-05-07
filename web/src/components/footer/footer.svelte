<script lang="ts">
  import type SheetData from '$types/data';
  import Icon from '@iconify/svelte';

  type $$Props = {
    footer: SheetData['footer'];
  };

  export let footer: $$Props['footer'];
</script>

<div class="mb-4 flex h-8 items-center gap-2">
  <div class="flex items-center gap-2 rounded-md bg-slate-600 px-2">
    <Icon icon="mingcute:user-2-fill" class="h-4 w-4" />
    {footer.serverId}
  </div>
  <div class="flex items-center gap-2 rounded-md bg-slate-600 px-2">
    <Icon icon="mingcute:group-fill" class="h-4 w-4" />
    {footer.playerCount}/{footer.maxPlayers}
  </div>
</div>
