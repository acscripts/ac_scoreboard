import './index.pcss';
import App from './App.svelte';
import { isEnvBrowser } from '$utils/misc';

const app = new App({
  target: document.getElementById('app')!,
});

if (isEnvBrowser()) {
  const root = document.getElementById('app');

  root!.style.backgroundImage = 'url("https://i.ibb.co/B6vJKtS/image.png")';
  root!.style.backgroundSize = 'cover';
  root!.style.backgroundRepeat = 'no-repeat';
  root!.style.backgroundPosition = 'center';
}

export default app;
