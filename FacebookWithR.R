# Set up and connect with FB API
install.packages("devtools")
library(devtools)
install_github("Rfacebook", "pablobarbera", subdir = "Rfacebook")
require("Rfacebook")
fb_oauth <- fbOAuth(app_id = "1598996763739943", app_secret = "eeac9438b0d03b979977a1f8937e1317",
                    extended_permissions = TRUE)
save(fb_oauth, file = "fb_oauth")
load("fb_oauth")

# Analyze FB with R
me <- getUsers("me", token = fb_oauth)
my_likes <- getLikes(user = "me", token = fb_oauth)
my_friends <- getFriends(token = fb_oauth, simplify = TRUE)
my_friends_info <- getUsers(my_friends$id, token=fb_oauth, private_info=TRUE)
my_network <- getNetwork(fb_oauth, format="adj.matrix")
singletons <- rowSums(my_network)==0 # friends who are friends with me alone

require(igraph)
my_graph <- graph.adjacency(my_network[!singletons,!singletons])
layout <- layout.drl(my_graph,options=list(simmer.attraction=0))
plot(my_graph, vertex.size=2, 
     #vertex.label=NA, 
     vertex.label.cex=0.5,
     edge.arrow.size=0, edge.curved=TRUE,layout=layout)