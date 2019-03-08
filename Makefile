# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: emuckens <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2017/11/07 16:46:27 by emuckens          #+#    #+#              #
#    Updated: 2018/11/26 13:30:44 by emuckens         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = ft_printf

#==============================================================================#
#					 		 	  COMPILATION								   
#==============================================================================#

CFLAGS		:= -Wall -Werror -Wextra
FSANIFLAGS	:= -fsanitize=address
CC		:= gcc $(FLAGS)
CCF  		:= $(CC) $(FSANIFLAGS)

#==============================================================================#
#								DIRECTORIES									    
#==============================================================================#

SCR_DIR		:= srcs
HEAD_DIR	:= includes
BIN_DIR		:= bin

#==============================================================================#
#								    FILES									   
#==============================================================================#


SRCS_NOPREFIX = add_prefix.c add_sign.c add_to_buffer.c ft_strncpyi.c \
		apply_specs.c apply_specs_cs.c colors.c ft_printbit.c \
		ft_itoa_base_cust.c itoa_cust_var.c unicode.c attributes_tools.c \
		read_until_arg.c ft_printf.c init_or_clear.c read_attributes.c \
		read_until_arg.c getarg_int.c getarg_nomod.c getarg_uns.c nblen.c \
		negative_arg.c ft_bigc.c ft_bigo.c ft_bigu.c ft_c.c ft_i.c ft_o.c \
		ft_u.c ft_bigd.c ft_bigs.c ft_bigx.c ft_d.c ft_noconv.c ft_p.c ft_s.c \
		ft_x.c ft_n.c ft_b.c mng_nullarg.c ftp_abs.c ftp_isalpha.c \
		ftp_isdigit.c ftp_maxint.c ftp_nblen.c ftp_strcstr.c ftp_strequ.c \
		ftp_strlen.c ftp_strnequ.c ftp_toupper.c ftp_strcmp.c ftp_strncmp.c

HEAD_NOPREFIX = ft_printf.h

SRC 		= $(patsubst %, $(SRC_DIR)/%, $(SRC_NOPREFIX))
HEAD		= $(patsubst %, $(HEAD_DIR)/$, $(HEAD_NOPREFIX))
BIN		= $(patsubst %.c, $(BIN_DIR)/%.o, $(SRC_NOPREFIX))

TAGS = ./tags

#==============================================================================#
#							       RULES									    
#==============================================================================#


.PHONY: all clean fclean re debug

all:
	@make $(NAME)

$(NAME) : $(HEAD) $(BIN) Makefile $(TAGS)
	@echo "\033[22;35mbuilding $(NAME)...\033[0m"
	@ar rc $(NAME) $(BIN)
	@ranlib $(NAME)
	@echo ">>> \033[01;32m$(NAME) READY !\n\033[0m"


$(TAGS) :
	@touch ./tags
	@ctags -R

$(BIN_DIR)/%.o: $(SRC_DIR)/%.c $(HEAD) $(TAGS) Makefile | $(BIN_DIR)
	@$(CC) -I $(HEAD_DIR) -o $@ -c $<
	@printf "\033[22;35mgenerating binary.... [ % ]\033[0m\r" $@ 


$(BIN_DIR):
	@mkdir -p $(BIN_DIR)


clean:
	@echo "cleaning $(NAME) binaries..."
	@rm -f $(BIN)
	@rm -rf $(BIN_DIR)
	@echo "\033[01;34mBinaries removed from $(BIN_DIR) directory.\n\033[0m"

fclean: clean
	@echo "cleaning $(NAME) executable..."
	@rm -f $(NAME)
	@echo "\033[01;34mExecutable $(NAME) removed.\n\033[0m"

re:
	@make -s fclean
	@make -s all

debug: $(BIN)
	@echo "\033[01;31mbuilding $(NAME) in DEBUG MODE...\033[0m"
	@$(CCF) -o $(NAME) $(BIN)
	@echo "\033[01;32m$(NAME) READY\033[0m"
