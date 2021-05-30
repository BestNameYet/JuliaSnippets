module Cards

abstract type AbstractSuit end
struct NoSuit <: AbstractSuit end
struct IdentitySuit <: AbstractSuit end
struct Hearts <: AbstractSuit end
struct Diamonds <: AbstractSuit end
struct Clubs <: AbstractSuit end
struct Spades <: AbstractSuit end

abstract type AbstractRank end
struct NoRank <: AbstractRank end
struct IdentityRank <: AbstractRank end
struct Ace <: AbstractRank end
struct King <: AbstractRank end
struct Queen <: AbstractRank end
struct Jack <: AbstractRank end

function makeInstance(singletontype::Union{AbstractRank, AbstractSuit})
return singletontype()
end

struct Card{R<:AbstractRank, S<:AbstractSuit}
suit::S
rank::R
function Card(_suit::AbstractSuit=makeInstance(NoSuit), _rank::AbstractRank=makeInstance(NoRank); rank=_rank, suit=_suit)
return new(suit, rank)
end

end



end
