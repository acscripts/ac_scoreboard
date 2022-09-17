import { createContext, useEffect, useState } from "react";
import {
  Drawer,
  DrawerBody,
  DrawerFooter,
  DrawerHeader,
  DrawerOverlay,
  DrawerContent,
  Button,
  VStack,
} from "@chakra-ui/react";
import GroupList from "./body/GroupList";
import PlayerList from "./body/PlayerList";
import Footer from "./Footer";
import { Group } from "../interfaces/group";
import { Player } from "../interfaces/player";
import { Locale } from "../interfaces/locale";
import { useNuiEvent } from "../hooks/useNuiEvent";
import { fetchNui } from "../utils/fetchNui";
import { isEnvBrowser } from "../utils/misc";
import { debugData } from "../utils/debugData";

interface InitialProps {
  serverName: string;
  serverId: number;
  locales: Locale;
}

interface VariableProps {
  playerCount: number;
  maxPlayers: number;
  groups: Array<Group>;
  players: Array<Player>;
}

interface Props extends InitialProps, VariableProps {}

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
  players: [
    { name: "Ingrim", id: 73 },
    { name: "Branden", id: 67 },
    { name: "Burke", id: 18 },
    { name: "Bob with very long name", id: 87 },
    { name: "Marven", id: 15 },
    { name: "Artie", id: 100 },
    { name: "Ben", id: 32 },
    { name: "Dewain", id: 12 },
    { name: "Hollis", id: 71 },
    { name: "Tommy", id: 5 },
    { name: "Ingrim", id: 78 },
    { name: "Raphael", id: 11 },
    { name: "Cristobal", id: 67 },
    { name: "Efren", id: 50 },
    { name: "Thorstein", id: 47 },
    { name: "Fredek", id: 15 },
    { name: "Roley", id: 54 },
    { name: "Perkin", id: 47 },
    { name: "Josias", id: 63 },
    { name: "Charley", id: 93 },
  ],
  locales: {
    ui_group: "Group",
    ui_count: "Count",
    ui_name: "Name",
    ui_id: "ID",
    ui_player_count: "Player count",
    ui_your_id: "Your server ID",
    ui_copied: "Copied to clipboard!",
  },
};

debugData([
  {
    action: "setData",
    data: mockData,
  },
]);

export const LocaleContext = createContext(mockData.locales);

const Scoreboard: React.FC = () => {
  const [visible, setVisible] = useState(false);
  const [data, setData] = useState<Props>(mockData);

  useNuiEvent("setVisible", setVisible);
  useNuiEvent<Props>("setData", (newData) => {
    setData((data) => ({ ...data, ...newData }));
  });

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
      <LocaleContext.Provider value={data.locales}>
        <Drawer isOpen={visible} onClose={closeScoreboard} placement="right">
          <DrawerOverlay />
          <DrawerContent>
            <DrawerHeader>{data.serverName}</DrawerHeader>

            <DrawerBody>
              <VStack spacing={6}>
                <GroupList groups={data.groups} />
                <PlayerList players={data.players} />
              </VStack>
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
      </LocaleContext.Provider>
    </>
  );
};

export default Scoreboard;
