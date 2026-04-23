part of '../mentorx_ui.dart';

class AvatarSwitcherItem extends StatelessWidget {
  const AvatarSwitcherItem({
    super.key,
    required this.name,
    this.imageUrl,
    required this.isSelected,
    required this.onTap,
  });

  final String name;
  final String? imageUrl;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return PressableBox(
      onPress: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected 
                    ? context.brandPrimaryColor
                    : Colors.transparent,
                width: 2,
              ),
            ),
            child: CircleAvatar(
              radius: 28,
              backgroundColor: isSelected 
                  ? context.brandPrimaryColor.withValues(alpha: 0.1)
                  : context.backgroundSecondaryColor,
              backgroundImage: imageUrl != null 
                  ? NetworkImage(imageUrl!) 
                  : null,
              child: imageUrl == null 
                  ? Text(
                      name.isNotEmpty ? name[0] : '?',
                      style: TextStyle(
                        color: isSelected ? context.brandPrimaryColor : context.textSecondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    )
                  : null,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            name,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              fontSize: 13,
              color: isSelected ? context.brandPrimaryColor : context.textPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
