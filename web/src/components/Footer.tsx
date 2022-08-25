import { Text, Tag, TagLeftIcon, HStack } from "@chakra-ui/react";
import { FaUserAlt, FaUserFriends } from "react-icons/fa";

interface Props {
  playerCount: number;
  maxPlayers: number;
  serverId: number;
}

const Footer: React.FC<Props> = (props: Props) => {
  return (
    <HStack>
      <Tag>
        <TagLeftIcon as={FaUserFriends} boxSize={4} />
        <Text>
          {props.playerCount} / {props.maxPlayers}
        </Text>
      </Tag>
      <Tag>
        <TagLeftIcon as={FaUserAlt} boxSize={3} />
        <Text>{props.serverId}</Text>
      </Tag>
    </HStack>
  );
};

export default Footer;
