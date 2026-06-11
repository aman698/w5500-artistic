/**
 * @file command_parser.c
 * @brief TCP command parser implementation
 * 
 * Supported commands:
 * - R1,0 / R1,1  (Relay 1 off/on)
 * - R2,0 / R2,1  (Relay 2 off/on)
 * - R3,0 / R3,1  (Relay 3 off/on)
 * - R4,0 / R4,1  (Relay 4 off/on)
 * - R5,0 / R5,1  (Relay 5 off/on)
 * - R6,0 / R6,1  (Relay 6 off/on)
 */

#include "command_parser.h"
#include "relay_control.h"
#include <string.h>
#include <stdlib.h>

/**
 * Parse a null-terminated command string
 * Returns 0 on success, -1 on error
 */
int command_parser_execute(const char *cmd_str, int len)
{
    char cmd_copy[64];
    char *cmd = NULL;
    char *value_str = NULL;
    char *comma_pos;
    int relay_num = 0;
    int relay_state = 0;
    
    if (len == 0 || len >= 64) return -1;
    
    /* Copy command to working buffer */
    strncpy(cmd_copy, cmd_str, len);
    cmd_copy[len] = '\0';
    
    /* Find comma separator */
    comma_pos = strchr(cmd_copy, ',');
    if (!comma_pos) return -1;
    
    /* Split into command and value */
    *comma_pos = '\0';
    cmd = cmd_copy;
    value_str = comma_pos + 1;
    
    /* Parse relay command (R1-R6) */
    if (cmd[0] == 'R' && cmd[1] >= '1' && cmd[1] <= '6' && cmd[2] == '\0') {
        relay_num = cmd[1] - '0';
        relay_state = atoi(value_str);
        
        /* Set relay state (0 = off, 1 = on) */
        relay_control_set(relay_num, relay_state);
        return 0;
    }
    
    return -1;
}

/**
 * Check if command is valid without executing
 */
int command_parser_is_valid(const char *cmd_str, int len)
{
    if (len < 3 || len >= 64) return 0;
    
    if (cmd_str[0] == 'R' && cmd_str[1] >= '1' && cmd_str[1] <= '6') {
        /* Check for comma at position 2 */
        if (strchr(cmd_str, ',') != NULL) {
            return 1;
        }
    }
    
    return 0;
}
