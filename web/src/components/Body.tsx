import { VStack, Flex, Text, Tag } from "@chakra-ui/react";
import { Group } from "../interfaces/group";

interface Props {
  groups: Array<Group>;
}

const Body: React.FC<Props> = (props: Props) => {
  return (
    <VStack>
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
    </VStack>
  );
};

export default Body;
