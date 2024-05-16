<script lang="ts">
  import { Tooltip as TooltipPrimitive } from 'bits-ui';

  type $$Props = TooltipPrimitive.TriggerProps;

  let className: $$Props['class'] = undefined;
  export { className as class };
</script>

<TooltipPrimitive.Trigger asChild let:builder class={className} {...$$restProps}>
  <div use:builder.action {...builder}>
    <slot />
  </div>
</TooltipPrimitive.Trigger>
