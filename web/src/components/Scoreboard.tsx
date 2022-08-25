import { useState } from "react";
import {
  useDisclosure,
  Drawer,
  DrawerBody,
  DrawerFooter,
  DrawerHeader,
  DrawerOverlay,
  DrawerContent,
  Button,
  Text,
} from "@chakra-ui/react";
import Body from "./Body";
import Footer from "./Footer";
import { Group } from "../interfaces/group";
import { useNuiEvent } from "../hooks/useNuiEvent";
import { isEnvBrowser } from "../utils/misc";
import { debugData } from "../utils/debugData";

interface Props {
  serverName: string;
  playerCount: number;
  maxPlayers: number;
  serverId: number;
  groups: Array<Group>;
}

const mockData: Props = {
  serverName: "Server Name",
  playerCount: 20,
  maxPlayers: 64,
  serverId: 6,
  groups: [
    { label: "Police", count: 12 },
    { label: "EMS", count: 7 },
    { label: "Taxi", count: 5 },
    { label: "Mechanic", count: 0 },
  ],
};

debugData([
  {
    action: "setData",
    data: mockData,
  },
]);

const Scoreboard: React.FC = () => {
  const { isOpen, onOpen, onClose } = useDisclosure();
  const [data, setData] = useState<Props>(mockData);

  useNuiEvent("setVisible", onOpen);
  useNuiEvent<Props>("setData", setData);

  return (
    <>
      {isEnvBrowser() && (
        <Button colorScheme="blue" onClick={onOpen}>
          Open
        </Button>
      )}
      <Drawer isOpen={isOpen} onClose={onClose} placement="right">
        <DrawerOverlay />
        <DrawerContent>
          <DrawerHeader>{data.serverName}</DrawerHeader>

          <DrawerBody>
            <Body groups={data.groups} />
          </DrawerBody>

          <DrawerFooter justifyContent="center">
            <Footer
              playerCount={data.playerCount}
              maxPlayers={data.maxPlayers}
              serverId={data.serverId}
            />
          </DrawerFooter>
        </DrawerContent>
      </Drawer>
    </>
  );
};

export default Scoreboard;
