import { Stack, Flex, Text, Tag } from "@chakra-ui/react";
import { Player } from "../../interfaces/player";
import SectionHeader from "./SectionHeader";

interface Props {
  players: Array<Player>;
}

const Players: React.FC<Props> = (props: Props) => {
  return (
    <Stack direction="column" spacing={1}>
      <SectionHeader left="Name" right="ID" />
      {props.players.map((player, index) => (
        <Flex
          key={index}
          w="2xs"
          p={2}
          justifyContent="space-between"
          bg="gray.800"
          borderRadius={4}
        >
          <Text noOfLines={1} casing="uppercase" fontWeight="medium">
            {player.name}
          </Text>
          <Tag>{player.id}</Tag>
        </Flex>
      ))}
    </Stack>
  );
};

export default Players;
