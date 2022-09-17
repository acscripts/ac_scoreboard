import { useContext } from "react";
import { LocaleContext } from "../Scoreboard";
import { Stack, Flex, Text, Tag } from "@chakra-ui/react";
import { Group } from "../../interfaces/group";
import SectionHeader from "./SectionHeader";

interface Props {
  groups: Array<Group>;
}

const GroupList: React.FC<Props> = (props: Props) => {
  const locales = useContext(LocaleContext);

  return (
    <Stack direction="column" spacing="1">
      <SectionHeader left={locales["ui_group"]} right={locales["ui_count"]} />
      {props.groups.map((group, index) => (
        <Flex
          key={index}
          w="2xs"
          p={2}
          justifyContent="space-between"
          bg="gray.800"
          borderRadius={4}
        >
          <Text noOfLines={1} casing="uppercase" fontWeight="medium">
            {group.label}
          </Text>
          <Tag colorScheme={group.count <= 0 ? "red" : "gray"}>
            {group.count}
          </Tag>
        </Flex>
      ))}
    </Stack>
  );
};

export default GroupList;
