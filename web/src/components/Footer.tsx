import { Text, Tag, TagLeftIcon, HStack, Tooltip } from "@chakra-ui/react";
import { FaUserAlt, FaUserFriends } from "react-icons/fa";

interface Props {
  playerCount: number;
  maxPlayers: number;
  serverId: number;
}

const Footer: React.FC<Props> = (props: Props) => {
  return (
    <HStack>
      <Tooltip label="Player count">
        <Tag>
          <TagLeftIcon as={FaUserFriends} boxSize={4} />
          <Text>
            {props.playerCount} / {props.maxPlayers}
          </Text>
        </Tag>
      </Tooltip>
      <Tooltip label="Your server ID">
        <Tag>
          <TagLeftIcon as={FaUserAlt} boxSize={3} />
          <Text>{props.serverId}</Text>
        </Tag>
      </Tooltip>
    </HStack>
  );
};

export default Footer;
