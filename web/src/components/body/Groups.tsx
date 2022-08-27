import { Stack, Flex, Text, Tag } from "@chakra-ui/react";
import { Group } from "../../interfaces/group";
import SectionHeader from "./SectionHeader";

interface Props {
  groups: Array<Group>;
}

const Groups: React.FC<Props> = (props: Props) => {
  return (
    <Stack direction="column" spacing="1">
      <SectionHeader left="Group" right="Count" />
      {props.groups.map((group, index) => (
        <Flex
          key={index}
          w="2xs"
          p={2}
          justifyContent="space-between"
          bg="gray.800"
          borderRadius={4}
        >
          <Text textTransform="uppercase" fontWeight="medium">
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

export default Groups;
