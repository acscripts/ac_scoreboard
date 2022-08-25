import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import { VisibilityProvider } from './providers/VisibilityProvider';

import './index.css'
import App from './App'

const container = document.getElementById('root') as HTMLElement;
const root = createRoot(container);
root.render(
  <StrictMode>
    <VisibilityProvider>
      <App />
    </VisibilityProvider>
  </StrictMode>
);
