import { useEffect, useState } from "react";
import {
  Drawer,
  DrawerBody,
  DrawerFooter,
  DrawerHeader,
  DrawerOverlay,
  DrawerContent,
  Button,
} from "@chakra-ui/react";
import Body from "./Body";
import Footer from "./Footer";
import { Group } from "../interfaces/group";
import { useNuiEvent } from "../hooks/useNuiEvent";
import { fetchNui } from "../utils/fetchNui";
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
  const [visible, setVisible] = useState(false);
  const [data, setData] = useState<Props>(mockData);

  useNuiEvent("setVisible", setVisible);
  useNuiEvent<Props>("setData", setData);

  const closeScoreboard = () => {
    setVisible(false);
    fetchNui("close");
  };

  useEffect(() => {
    if (!visible) return;

    const keyHandler = (e: KeyboardEvent) => {
      if (e.code === "Escape") closeScoreboard();
    };

    window.addEventListener("keydown", keyHandler);
    return () => window.removeEventListener("keydown", keyHandler);
  }, [visible]);

  return (
    <>
      {isEnvBrowser() && (
        <Button colorScheme="blue" onClick={() => setVisible(true)}>
          Open
        </Button>
      )}
      <Drawer isOpen={visible} onClose={closeScoreboard} placement="right">
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
