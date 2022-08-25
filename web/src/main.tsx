import { StrictMode } from "react";
import { createRoot } from "react-dom/client";
import { ChakraProvider } from "@chakra-ui/react";
import { VisibilityProvider } from "./providers/VisibilityProvider";
import { debugData } from "./utils/debugData";

import { theme } from "./theme";
import "./index.css";
import App from "./App";

debugData([
  {
    action: "setVisible",
    data: true,
  },
]);

const container = document.getElementById("root") as HTMLElement;
const root = createRoot(container);
root.render(
  <StrictMode>
    <VisibilityProvider>
      <ChakraProvider theme={theme}>
        <App />
      </ChakraProvider>
    </VisibilityProvider>
  </StrictMode>
);
