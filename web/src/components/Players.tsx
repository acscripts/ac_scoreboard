import { VStack, Flex, Text, Tag } from "@chakra-ui/react";
import { Player } from "../interfaces/player";

interface Props {
  players: Array<Player>;
}

const Players: React.FC<Props> = (props: Props) => {
  return (
    <VStack>
      {props.players.map((player, index) => (
        <Flex
          key={index}
          w="2xs"
          p={2}
          justifyContent="space-between"
          bg="gray.800"
          borderRadius={4}
        >
          <Text textTransform="uppercase" fontWeight="medium">
            {player.name}
          </Text>
          <Tag>
            {player.id}
          </Tag>
        </Flex>
      ))}
    </VStack>
  );
};

export default Players;
