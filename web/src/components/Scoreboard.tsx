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
import type { Player } from "../interfaces/player";
import type { Locale } from "../interfaces/locale";
import { useNuiEvent } from "../hooks/useNuiEvent";
import { fetchNui } from "../utils/fetchNui";
import { isEnvBrowser } from "../utils/misc";
import { debugData } from "../utils/debugData";

interface InitialProps {
  serverName: string;
  visibleParts: "both" | "groups" | "players";
  drawerSide: "left" | "right";
  serverId: number;
  locales: Locale;
}

interface VariableProps {
  playerCount: number;
  maxPlayers: number;
  groups?: Array<Group>;
  players?: Player;
}

interface Props extends InitialProps, VariableProps {}

const mockData: Props = {
  serverName: "Server Name",
  visibleParts: "both",
  drawerSide: "right",
  playerCount: 20,
  maxPlayers: 64,
  serverId: 6,
  groups: [
    { label: "Police", count: 12 },
    { label: "EMS", count: 7, separator: true },
    { label: "Taxi", count: 5 },
    { label: "Mechanic", count: 0 },
  ],
  players: {
    "73": "Ingrim",
    "67": "Branden",
    "18": "Burke",
    "87": "Bob with very long name",
    "15": "Marven",
    "100": "Artie",
    "32": "Ben",
    "12": "Dewain",
    "71": "Hollis",
    "5": "Tommy",
    "78": "Ingrim",
    "11": "Raphael",
    "68": "Cristobal",
    "50": "Efren",
    "47": "Thorstein",
    "16": "Fredek",
    "54": "Roley",
    "48": "Perkin",
    "63": "Josias",
    "93": "Charley",
  },
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
        <Drawer
          isOpen={visible}
          onClose={closeScoreboard}
          placement={data.drawerSide}
          blockScrollOnMount={false}
        >
          <DrawerOverlay />
          <DrawerContent>
            <DrawerHeader>{data.serverName}</DrawerHeader>

            <DrawerBody>
              <VStack spacing={6}>
                {data.groups &&
                  (data.visibleParts === "both" ||
                    data.visibleParts === "groups") && (
                    <GroupList groups={data.groups} />
                  )}

                {data.players &&
                  (data.visibleParts === "both" ||
                    data.visibleParts === "players") && (
                    <PlayerList players={data.players} />
                  )}
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
