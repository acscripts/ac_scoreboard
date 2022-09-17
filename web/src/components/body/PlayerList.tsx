import { useContext } from "react";
import { LocaleContext } from "../Scoreboard";
import { Stack, Flex, Text, Tag } from "@chakra-ui/react";
import { Player } from "../../interfaces/player";
import SectionHeader from "./SectionHeader";

interface Props {
  players: Player;
}

const PlayerList: React.FC<Props> = (props: Props) => {
  const locales = useContext(LocaleContext);

  return (
    <Stack direction="column" spacing={1}>
      <SectionHeader left={locales["ui_name"]} right={locales["ui_id"]} />
      {Object.entries(props.players).map(([id, name], index) => (
        <Flex
          key={index}
          w="2xs"
          p={2}
          justifyContent="space-between"
          bg="gray.800"
          borderRadius={4}
        >
          <Text noOfLines={1} casing="uppercase" fontWeight="medium">
            {name}
          </Text>
          <Tag>{id}</Tag>
        </Flex>
      ))}
    </Stack>
  );
};

export default PlayerList;
