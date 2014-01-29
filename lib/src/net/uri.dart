part of restlib.core.net;

abstract class URI extends IRI {  
  static URI relativeReference(final URI base, final URI relative) =>
      _relativeReference(base, relative, _URI._builder, Path.EMPTY);
  
  Option<Authority> get authority;
  Path get path;
  
  URI canonicalize();
}