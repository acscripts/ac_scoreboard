import {
  useDisclosure,
  Drawer,
  DrawerBody,
  DrawerFooter,
  DrawerHeader,
  DrawerOverlay,
  DrawerContent,
  Text,
} from "@chakra-ui/react";
import { useState } from "react";
import { useNuiEvent } from "../hooks/useNuiEvent";
import { debugData } from "../utils/debugData";

interface Props {
  playerCount: number;
  maxPlayers: number;
}

debugData([
  {
    action: "setData",
    data: {
      playerCount: 20,
      maxPlayers: 64,
    },
  },
]);

const Scoreboard: React.FC = () => {
  const { isOpen, onOpen, onClose } = useDisclosure();
  const [playerCount, setPlayerCount] = useState(0);
  const [maxPlayers, setMaxPlayers] = useState(0);

  useNuiEvent("setVisible", onOpen);

  useNuiEvent<Props>("setData", (data) => {
    setPlayerCount(data.playerCount);
    setMaxPlayers(data.maxPlayers);
  });

  return (
    <>
      <Drawer isOpen={isOpen} onClose={onClose} placement="right">
        <DrawerOverlay />
        <DrawerContent>
          <DrawerHeader>Some header</DrawerHeader>

          <DrawerBody>
            <Text>Some content...</Text>
          </DrawerBody>

          <DrawerFooter>
            <Text>
              {playerCount}/{maxPlayers}
            </Text>
          </DrawerFooter>
        </DrawerContent>
      </Drawer>
    </>
  );
};

export default Scoreboard;
