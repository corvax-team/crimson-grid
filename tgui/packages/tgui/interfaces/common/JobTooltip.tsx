/// CORVAX FILE
import { Box } from 'tgui-core/components';

type JobTooltipProps = {
  description: string;
  restrictions?: string[];
  prioritized?: boolean;
  unavailableReason?: string | null;
};

/// Shared job tooltip for the character setup and latejoin menus.
export function JobTooltip(props: JobTooltipProps) {
  const { description, restrictions, prioritized, unavailableReason } = props;

  return (
    <Box>
      {!!prioritized && (
        <Box bold mb={0.5}>
          На эту роль срочно нужны люди!
        </Box>
      )}
      <Box mb={restrictions && restrictions.length > 0 ? 0.5 : 0}>
        {description}
      </Box>
      {!!restrictions?.length && (
        <Box>
          <Box bold>Ограничения:</Box>
          {restrictions.map((restriction, index) => (
            <Box key={`${index}-${restriction}`}>• {restriction}</Box>
          ))}
        </Box>
      )}
      {!!unavailableReason && (
        <Box mt={0.5} italic>
          {unavailableReason}
        </Box>
      )}
    </Box>
  );
}
