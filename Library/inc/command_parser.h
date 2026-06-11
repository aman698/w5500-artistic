/**
 * @file command_parser.h
 * @brief TCP command parser
 */

#ifndef __COMMAND_PARSER_H
#define __COMMAND_PARSER_H

#include "stm8s.h"

/* Parse command string (e.g., "R1,1" for relay 1 on) */
int command_parser_execute(const char *cmd_str, int len);

/* Check if command is valid */
int command_parser_is_valid(const char *cmd_str, int len);

#endif /* __COMMAND_PARSER_H */
