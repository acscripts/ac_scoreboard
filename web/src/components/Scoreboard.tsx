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
  Tag,
  TagLeftIcon,
  HStack,
} from "@chakra-ui/react";
import { useState } from "react";
import { FaUserAlt, FaUserFriends } from "react-icons/fa";
import { useNuiEvent } from "../hooks/useNuiEvent";
import { isEnvBrowser } from "../utils/misc";
import { debugData } from "../utils/debugData";

interface Props {
  serverName: string;
  playerCount: number;
  maxPlayers: number;
  serverId: number;
}

const mockData: Props = {
  serverName: "Server Name",
  playerCount: 20,
  maxPlayers: 64,
  serverId: 6,
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
            <Text>Some content...</Text>
          </DrawerBody>

          <DrawerFooter justifyContent="center">
            <HStack>
              <Tag>
                <TagLeftIcon as={FaUserFriends} boxSize={4} />
                <Text>
                  {data.playerCount} / {data.maxPlayers}
                </Text>
              </Tag>
              <Tag>
                <TagLeftIcon as={FaUserAlt} boxSize={3} />
                <Text>{data.serverId}</Text>
              </Tag>
            </HStack>
          </DrawerFooter>
        </DrawerContent>
      </Drawer>
    </>
  );
};

export default Scoreboard;
