#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
#########################

[[ ! -f /usr/bin/jq ]] && {
red "Downloading jq file!"
wget -q --no-check-certificate "https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64" -O /usr/bin/jq
chmod +x usr/bin/jq
}
dircreate() {
[[ -d /etc/.maAsiss ]] || mkdir /etc/.maAsiss
[[ -d /etc/.maAsiss/db_reseller ]] || mkdir /etc/.maAsiss/db_reseller
[[ -d /etc/.maAsiss/info-user-ss ]] || mkdir /etc/.maAsiss/info-user-ss
[[ -d /etc/.maAsiss/info-user-ssr ]] || mkdir /etc/.maAsiss/info-user-ssr
[[ -d /etc/.maAsiss/info-user-sstp ]] || mkdir /etc/.maAsiss/info-user-sstp
[[ -d /etc/.maAsiss/info-user-trgo ]] || mkdir /etc/.maAsiss/info-user-trgo
[[ -d /etc/.maAsiss/info-user-trojan ]] || mkdir /etc/.maAsiss/info-user-trojan
[[ -d /etc/.maAsiss/info-user-v2ray ]] || mkdir /etc/.maAsiss/info-user-v2ray
[[ -d /etc/.maAsiss/info-user-vless ]] || mkdir /etc/.maAsiss/info-user-vless
[[ -d /etc/.maAsiss/info-user-wg ]] || mkdir /etc/.maAsiss/info-user-wg
[[ -d /etc/.maAsiss/info-users ]] || mkdir /etc/.maAsiss/info-users
[[ -d /etc/.maAsiss/info-user-l2tp ]] || mkdir /etc/.maAsiss/info-user-l2tp
[[ -d /etc/.maAsiss/info-user-pptp ]] || mkdir /etc/.maAsiss/info-user-pptp
[[ -f /etc/.maAsiss/list_user ]] || touch /etc/.maAsiss/list_user
[[ ! -f /etc/.maAsiss/res_token ]] && touch /etc/.maAsiss/res_token
[[ ! -f /etc/.maAsiss/User_Generate_Token ]] && touch /etc/.maAsiss/User_Generate_Token

[[ -f /etc/.maAsiss/price ]] || {
cat <<-EOF >/etc/.maAsiss/price
Price SSH : 1
Price VMess : 1
Price VLess : 1
Price Trojan : 1
Price Trojan-GO : 1
Price Wireguard : 1
Price Shadowsocks : 1
Price Shadowsocks-R : 1
Price SSTP : 1
Price L2TP : 1
Price PPTP : 1
EOF
}
}

fun_botOnOff() {
dircreate
        [[ ! -f /etc/.maAsiss/bot.conf ]] && {
        echo -e "scvpn Bot Panel Installer
        "
        [[ ! -f /root/ResBotAuth ]] && {
        echo -ne "Input your Bot TOKEN : "
        read bot_tkn
        echo "Toket='$bot_tkn'" > /root/ResBotAuth
        echo -ne "Input your Admin ID : "
        read adm_ids
        echo "Admin_ID=$adm_ids" >> /root/ResBotAuth
        }
        echo -ne "Username admin panel use '@' [Ex: @ApaItuLeee] : "
        read admin_pnl
        [[ -z $admin_pnl ]] && admin_pnl="@ApaItuLeee"
        echo ""
        echo -ne "Limit trial for reseller create user trial [default:1] : "
        read limit_pnl
        [[ -z $limit_pnl ]] && limit_pnl="1"
        echo ""
        echo -ne "Your name store [dafult: scvpn-STORE] : "
        read store_pnl
        [[ -z $store_pnl ]] && store_pnl="scvpn-STORE"
        echo ""
cat <<-EOF >/etc/.maAsiss/bot.conf
admin_panel : $admin_pnl
limite_trial : $limit_pnl
store_name : $store_pnl
EOF
        clear
        echo -e "Info...\n"
        fun_bot1() {
            [[ ! -e "/etc/.maAsiss/.Shellbtsss" ]] && {
				wget -qO- https://raw.githubusercontent.com/apih46/BOT/main/bot_panel/ShellBot.sh >/etc/.maAsiss/.Shellbtsss
			}
			[[ "$(grep -wc "scvpn_bot" "/etc/rc.local")" = '0' ]] && {
			    sed -i '$ i\screen -dmS scvpn_bot bbt' /etc/rc.local >/dev/null 2>&1
			}
        }
        screen -dmS scvpn_bot bbt >/dev/null 2>&1
        fun_bot1
        [[ $(ps x | grep "scvpn_bot" | grep -v grep | wc -l) != '0' ]] && echo -e "\nBot successfully activated !" || echo -e "\nError1! Information not valid !"
        sleep 2
        menu
        } || {
       clear
        echo -e "Info...\n"
        fun_bot2() {
            screen -r -S "scvpn_bot" -X quit >/dev/null 2>&1
            [[ $(grep -wc "scvpn_bot" /etc/rc.local) != '0' ]] && {
                sed -i '/scvpn_bot/d' /etc/rc.local
            }
            rm -f /etc/.maAsiss/bot.conf
            sleep 1
        }
        fun_bot2
        echo -e "\nBot scvpn Stopped!"
        sleep 2
        menu
    }
}

fun_instbot() {
    echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo -e "         ⚠️ ATTENTION ⚠️"
    echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo -e " • Go to @BotFather Create Your own Bot by Type : /newbot"
    echo -e " • Go to @MissRose_bot And Get Your ID by Type : /id"
    echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo -e "Note:
    
    y = to start bot panel
    n = to cancel start bot panel
    d = delete configuration file before
    "
    echo -ne "Do you want to continue ? [y/n/d]: " 
    read resposta
    if [[ "$resposta" = 'd' ]]; then
    rm -f /etc/.maAsiss/bot.conf
    menu
    elif [[ "$resposta" = 'y' ]] || [[ "$resposta" = 'Y' ]]; then
        fun_botOnOff
    else
        echo -e "Returning..."
        sleep 1
        menu
    fi
}
[[ -f "/etc/.maAsiss/.Shellbtsss" ]] && fun_botOnOff || fun_instbot
